#ifndef ROOMSCENE_H
#define ROOMSCENE_H

#include <QQuickItem>
#include "clientplayer.h"
#include "client.h"
#include "structs.h"
#include "aux-skills.h"

class RoomScene : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
public:
    RoomScene(QQuickItem *parent = nullptr);

    Q_INVOKABLE QString _translateMovement(const CardsMoveStruct &move);

signals:
    void addChatter(const QString &chatter);
    void chat(const QString &chatter);
    void addPlayer(ClientPlayer *player);
    void removePlayer(const QString &player_name);
    void returnToStart();
    void chooseGeneral(const QStringList &generals);
    void chooseGeneralDone(const QString &general);
    void updateProperty(QVariantList args);
    void receiveLog(const QString &log_str);
    void addRobot(int num);
    void trust();
    // void moveCards(int moveId, QList<CardsMoveStruct> moves);
    void loseCards(int moveId, QList<CardsMoveStruct> moves);
    void getCards(int moveId, QList<CardsMoveStruct> moves);
    void setEmotion(const QString &who, const QString &emotion);
    void doAnimation(int name, const QStringList &args);
    void changeHp(const QString &who, int delta, int nature, bool losthp);
    void handleGameEvent(QVariantList args);
    void fillCards(const QList<int> &card_ids, const QList<int> &disabled_ids);
    void takeAmazingGrace(ClientPlayer *taker, int card_id, bool move_cards);
    void amazingGraceTaken(int cid);
    void clearPopupBox();
    void showGameOverBox();

    // void moveCards(const QVariant &moves);
    void enableCards(const QVariant &cardIds);
    void setPhotoReady(bool ready);
    void enablePhotos(const QVariant &seats);
    // void startEmotion(const QString &emotion, int seat);
    void playAudio(const QString &path);
    void setAcceptEnabled(bool enabled);
    void setRejectEnabled(bool enabled);
    void setFinishEnabled(bool enabled);
    void askToChooseCards(const QVariant &cards);

    void askToChoosePlayerCard(const QVariant &handcards, const QVariant &equips, const QVariant &delayedTricks);
    void playerCardSelected(int card_id);
    void showCard(int fromSeat, const QVariant &cards);
    void showOptions(const QString &skill_name, const QStringList &option);
    void optionSelected(const QString &option);
    void showArrangeCardBox(const QVariant &cards, const QVariant &capacities, const QVariant &names);
    void addLog(const QString &richText);
    void updateStatus(int oldStatus, int newStatus);

public slots:
    void chooseCard(const ClientPlayer *player, const QString &flags, const QString &reason,
    bool handcard_visible, Card::HandlingMethod method, QList<int> disabled_ids);
    void askForGuanxing(const QList<int> card_ids, bool up_only);
    void arrangeCardsDone(const QVariant &result);
};

#endif // ROOMSCENE_H
